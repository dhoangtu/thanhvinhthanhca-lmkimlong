% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Tín Thác Trong Tay Chúa" }
  composer = "Tv. 70"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  e8. e16 e8 f |
  f4 d8 d |
  e4 d8 c |
  c e a, (c) |
  d4 r8 c |
  f f4 d8 |
  d d f f |
  g4. g8 |
  d' d4 d8 |
  c4 \bar "||" \break
  
  <> \tweak extra-offset #'(-6.5 . -2.4) _\markup { \bold "ĐK:" }
  c8. c16 |
  c8 a r a |
  g8. g16 b8 c |
  d2 ~ |
  d4 c8 c |
  d8. e16 c8 d16 (c) |
  a4. a8 |
  g b4 d8 |
  c2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*9
  r4
  e8. e16 |
  e8 c r f |
  e8. e16 d8 e |
  g2 ~ |
  g4 a8 a |
  b8. c16 a8 [g] |
  f4. f8 |
  e d4 f8 |
  e2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Xin nên như núi đá con nương náu,
      như thành trì cứu độ con,
      Vì núi đá và thành trì bảo vệ con là chính Chúa,
      Chúa ơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đưa con xa móng vuốt quân gian ác,
	    xa bọn độc dữ hiểm nguy,
	    Vì chính Chúa là niềm cậy trông
	    của con từ tấm bé Chúa ơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Con khôn ngơi cất tiếng tôn vinh Chúa,
	    tay Ngài hằng dắt dìu con,
	    Vì có Chúa là thành trì để ẩn thân,
	    Nguyện mãi mãi tán dương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Con đây luôn tín thác trong tay Chúa,
	    loan truyền lộc phúc Ngài ban,
	    Từ tấm bé đà được Ngài thương dậy dỗ
	    và dẫn dắt tới nay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Khi cao niên, xế bóng,
	    van xin Chúa thương tình đừng nỡ bỏ con,
	    Vì khắp chốn địch thù bày mưu gian ác
	    và nhất trí chống con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bao vinh hoa Chúa sẽ ban chan chứa,
	    an ủi và vỗ về con,
	    Dù trước đó từng bị vùi dập khổ đau,
	    rồi Chúa mới kéo lên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Theo cung tơ réo rắt con ca hát,
	    đa tạ Ngài cứu độ con,
	    Và nhắc nhớ ngàn đời Ngài luôn công chính,
	    là Đấng Thánh Ích -- diên.
    }
  >>
  %\set stanza = "ĐK:"
  \set stanza = ""
  Môi con reo hò theo nhịp đàn ngợi khen Chúa,
  Và hồn con Chúa đã cứu độ vui mừng chung tiếng ca.
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
  %system-system-spacing = #'((basic-distance . 0.1) (padding . 1))
  page-count = 1
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
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
     (padding . 1)
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
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
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
% kết thúc mã nguồn

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
