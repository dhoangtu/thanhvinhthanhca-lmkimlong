% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Chớ Ngoảnh Mặt Đi" }
  composer = "Tv. 54"
  tagline = ##f
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
     (set! all-grob-descriptions
           (cons ((@@ (lily) completize-grob-entry)
                  (cons grob-name grob-entry))
                 all-grob-descriptions)))

#(add-grob-definition
    'StanzaNumberSpanner
    `((direction . ,LEFT)
      (font-series . bold)
      (padding . 1.0)
      (side-axis . ,X)
      (stencil . ,ly:text-interface::print)
      (X-offset . ,ly:side-position-interface::x-aligned-side)
      (Y-extent . ,grob::always-Y-extent-from-stencil)
      (meta . ((class . Spanner)
               (interfaces . (font-interface
                              side-position-interface
                              stanza-number-interface
                              text-interface))))))

\layout {
    \context {
      \Global
      \grobdescriptions #all-grob-descriptions
    }
    \context {
      \Score
      \remove Stanza_number_align_engraver
      \consists
        #(lambda (context)
           (let ((texts '())
                 (syllables '()))
             (make-engraver
              (acknowledgers
               ((stanza-number-interface engraver grob source-engraver)
                  (set! texts (cons grob texts)))
               ((lyric-syllable-interface engraver grob source-engraver)
                  (set! syllables (cons grob syllables))))
              ((stop-translation-timestep engraver)
                 (for-each
                  (lambda (text)
                    (for-each
                     (lambda (syllable)
                       (ly:pointer-group-interface::add-grob
                        text
                        'side-support-elements
                        syllable))
                     syllables))
                  texts)
                 (set! syllables '())))))
    }
    \context {
      \Lyrics
      \remove Stanza_number_engraver
      \consists
        #(lambda (context)
           (let ((text #f)
                 (last-stanza #f))
             (make-engraver
              ((process-music engraver)
                 (let ((stanza (ly:context-property context 'stanza #f)))
                   (if (and stanza (not (equal? stanza last-stanza)))
                       (let ((column (ly:context-property context
'currentCommandColumn)))
                         (set! last-stanza stanza)
                         (if text
                             (ly:spanner-set-bound! text RIGHT column))
                         (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                         (ly:grob-set-property! text 'text stanza)
                         (ly:spanner-set-bound! text LEFT column)))))
              ((finalize engraver)
                 (if text
                     (let ((column (ly:context-property context
'currentCommandColumn)))
                       (ly:spanner-set-bound! text RIGHT column)))))))
      \override StanzaNumberSpanner.horizon-padding = 10000
    }
}

stanzaReminderOff =
  \temporary \override StanzaNumberSpanner.after-line-breaking =
     #(lambda (grob)
        ;; Can be replaced with (not (first-broken-spanner? grob)) in 2.23.
        (if (let ((siblings (ly:spanner-broken-into (ly:grob-original grob))))
              (and (pair? siblings)
                   (not (eq? grob (car siblings)))))
            (ly:grob-suicide! grob)))

stanzaReminderOn = \undo \stanzaReminderOff
% kết thúc mã nguồn

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \autoPageBreaksOff
  \partial 8 e8 |
  c'4. b8 |
  b8. c16 b8 a |
  gs4 a8 f |
  e4. e8 |
  c'4 a8 a |
  b2 |
  a8. a16 a8 c ~ |
  c b16 (c) d8 d |
  e2 |
  d8. c16 e8 d ~ |
  d b c e |
  a,2 \bar "||" \break
  
  a8. g16 f8 a |
  e4. e8 |
  c' b4 a8 |
  d2 |
  c8 c c d |
  e8. e16 a,8 b |
  
  \pageBreak
  
  r8 c b a |
  gs8. a16 e8 c' |
  r8 b b b |
  a8. d16 d8 e |
  b2 ~ |
  b4 c8 b16 (a) |
  e4. e8 |
  b8. e16 c'8 b |
  a2 ~ |
  a4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  e8 |
  a4. a8 |
  gs8. a16 d,8 f |
  e4 e8 d |
  c4. c8 |
  a'4 f8 f |
  e2 |
  a8. g!?16 f8 e ~ |
  e e16 (a) b8 b |
  c2 |
  b8. a16 c8 b ~ |
  b gs a gs |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Lạy Chúa, xin nghe tiếng con kêu cầu,
  Con khẩn nài, Ngài chớ ngoảnh mặt đi.
  Lòng bồn chồn con thở than rên xiết,
  Xin Ngài lắng nghe và mau đáp lời.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Lũ quân thù thét gào,
      phường bất nhân hò reo
      Họ hằm hằm xông tới cáo tội con,
      Tố con những điều con chẳng biết,
      Con nghe trong mình tim đau thắt lại,
      Bẫy tử thần kinh hoàng chụp xuống thân con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ước mong phải chi được cặp cánh chim bồ câu
	    Và dìu dặp bay tới cõi trời xa,
	    Lánh đi trong tận sa mạc vắng,
	    Mong sao qua thời phong ba bão bùng,
	    Ước trông hoài mau tìm được chốn dung thân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa cho miệng lưỡi họ xào xáo gây lộn nhau
	    Vì bạo hành tranh chấp khắp thành đô,
	    Bất công bạo tàn quanh đường phố,
	    Âm mưu thâm độc không khi khuất dạng,
	    Suốt đêm ngài tai họa đầy dẫy nơi nơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Giá như gặp kẻ thù nhạo báng hay cười chê
	    Lòng này đành câm nín lánh mặt đi,
	    Chứ đây bạn bè thân tình cũ,
	    Bao phen tâm đầu chia vui sớt sầu,
	    Giữa đô hội lên đền thờ Chúa bên nhau.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Những kêu cầu Chúa Trời,
	    Ngài xót thương đời tôi
	    Giờ từng giờ rên xiết Chúa đà nghe,
	    Cứu thân tôi khỏi tay độc dữ,
	    Tôi van xin Ngài muôn năm thống trị
	    Sẽ hủy diệt ai chẳng sợ kính Tôn Danh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Trút cho Ngài gánh sầu,
	    Ngài sẽ đỡ đần cho
	    Chẳng để người công chính phải ngả nghiêng.
	    Với quân gian tà chuyên đổ máu,
	    Đâu mong chi được an thân nửa đời,
	    Có tôi là tin cậy vào Chúa khôn ngơi.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
  ragged-bottom = ##t
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
