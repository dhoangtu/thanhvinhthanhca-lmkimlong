% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Con Xin Phó Thác Hồn Con" }
  composer = "Tv. 30"
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
      (padding . 0.5)
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
  g8 a f e |
  d4. c8 |
  a'4 r8 f16 f |
  g8 a d, e16 (d) |
  c2 |
  e8 c f (e) |
  d8. d16 e8 g |
  a4. b16 a |
  a8 g d' b |
  c4 r8 \bar "||" \break
  
  e,8 |
  e f f d |
  g4 g8 g |
  e4. a8 |
  a b b g |
  c4 r8 g |
  e'4 e8 c |
  d4 r8 g, |
  d'4 d8 b |
  \stemDown c2 ~ |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  R2*9
  r4.
  e,8 |
  e f f d |
  g4 e8 e |
  c4. f8 |
  fs g g f! |
  e4 r8 g |
  c4 c8 a |
  g4 r8 e |
  f4 g8 g |
  <e c>2 ~ |
  <e c>4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Con náu ẩn nơi Ngài,
      lạy Chúa đừng để con tủi nhục bao giờ,
      Xin giải thoát con vì Ngài công chính,
      Lắng tai nghe và cứu độ con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Như núi để bao bọc,
	    lạy Chúa tựa thành kiên cố để giữ gìn.
	    Xin Ngài đoái thương chỉ đường soi lối
	    Để uy danh Ngài mãi lừng vang.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Con hớn hở vui mừng
	    vì Chúa đà dủ thương đến phận cơ cùng,
	    Trong hồi khó nguy Ngài đà chăm sóc
	    Khiến con luôn rộng bước thảnh thơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Vương mắc cảnh cơ cực,
	    lay Chúa vì sầu đau mắt đã mỏi mòn,
	    Tâm hồn rã rời, tiều tụy thân xác
	    Ngước trông lên cầu Chúa dủ thương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Con vững tin nơi Ngài,
	    lạy Chúa, Ngài là Thiên Chúa con kính thờ,
	    Số phận của con nằm ở tay  Chúa,
	    Cứu qua tay người bách hại con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xin chiếu tỏa nhan Ngài,
	    lạy Chúa, phận bày tôi Chúa hãy cứu độ,
	    Cao cả biết bao lòng từ bi Chúa,
	    Xuống trên ai bền vững cậy tin.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Ai vững dạ trung thành cùng Chúa,
	    nào cùng yêu mến Ngài hết lòng.
	    Chúa gìn giữ ai một niềm trung tín.
	    Lũ kiêu căng Ngài khiến diệt vong.
    }
  >>
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Con xin phó thác hồn con trong tay Ngài,
  con xin phó thác hồn con,
  Ngài đã cứu độ con, lạy Chúa, Đấng thủy chung.
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
  page-count = 1
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
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
