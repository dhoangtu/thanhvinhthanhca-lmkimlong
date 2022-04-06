% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "No Say Ân Tình Chúa" }
  composer = "Tv. 89"
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
nhacPhienKhucSop = \relative c'' {
  \autoPageBreaksOff
  g8 g a (g) |
  fs4. d16 d |
  bf'8 bf a g |
  a4 r8 g16 a |
  f!?8 g16 (f) d8 c |
  d4 d8 d |
  d'8. bf16 g8 g |
  a2 |
  fs8 g16 (a) d,8 g16 (a) |
  bf4 a8 c |
  bf16 (c) d8 bf a |
  \partial 4. g4 r8 \bar "||"
  
  \pageBreak
  
  \set Staff.printKeyCancellation = ##f
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key g \major
  \partial 8 b8 |
  b8. c16 b8 g |
  a a r a |
  fs8. fs16 a8 a |
  g d r8 d16 d |
  d8 g fs g |
  a4 r8 c |
  c8. c16 b8 b |
  c8 d r a |
  a8. c16 c8 b |
  g a r d, |
  a'8. a16 fs8 a |
  g2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  R2*11
  r4.
  
  \set Staff.printKeyCancellation = ##f
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key g \major
  g8 |
  g8. a16 g8 e |
  d d r cs |
  d8. d16 d8 c |
  b b r b16 b |
  b8 b d e |
  fs4 r8 a |
  a8. a16 g8 g |
  a b r e, |
  fs8. a16 a8 g |
  e d r d |
  c8. c16 d8 c |
  b2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Qua muôn thế hệ, Ngài là chốn chúng con ẩn thân,
      Khi núi đồi chưa được tạo thành
      và hoàn vũ chưa được dựng nên,
      Ngài vẫn là Thiên Chúa
      Từ muôn thuở đến muôn muôn đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Khi nghe Chúa truyền là người thế trở lui bụi tro.
	    Nơi Chúa ngàn năm kể là gì,
	    tựa một trống canh, tựa ngày qua,
	    Tựa giấc mộng tan biến
	    Tựa hoa nở sớm hôm phai tàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Trong cơn nóng giận là Ngài khiến chúng con tàn vong,
	    Khi Chúa vạch rõ bao tội tình
	    dù thầm kín cũng được rạng soi.
	    Ngài nổi giận kinh khiếp
	    Làm cho đời chúng con lụi tàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Như hơi thở phào: này cuộc sống chúng con vụt tan,
	    Đo tuổi thọ trong ngoài bảy chục,
	    hoặc được tám mơi là cùng thôi,
	    Phần lớn là đau đớn,
	    Và trong khoảnh khắc đã qua rồi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Ai đâu biết được rằng nộ khí Chúa mạnh là bao,
	    Cơn nóng giận ai người hiểu được,
	    khẩn nài Chúa thương chỉ dậy cho,
	    Để trí lòng minh mẫn
	    Lần đo ngày tháng ở trên đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xin thương trở lại, Ngài đợi mãi tới khi nào đây?
	    Tôi tớ Ngài mong được dủ thương,
	    được nhìn ngắm bao là kỳ công,
	    Và để đoàn con cháu
	    Nhìn vinh hiển Chúa muôn muôn đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Mong ân đức Ngài còn dọi sáng mãi trên đoàn con.
	    Uy dũng Ngài muôn đời tồn tại,
	    hầu củng cố bao việc đoàn con,
	    Nguyện Chúa hằng củng cố
	    Việc tay của chúng con viên thành.
    }
  >>
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Xin cho chúng con được no say
  Ân tình của Chúa sớm mai này,
  để ngày ngày tưng bừng ca xướng.
  Xin thương ban tặng niềm vui sướng,
  bù lại những tháng năm sầu vương
  Ngài bắt nếm nhục nuốt cay.
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
}

TongNhip = {
  \key bf \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
