% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Ta Cứu Độ Con" }
  composer = "Tv. 34"
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
  \autoPageBreaksOff
  \partial 4 a8 bf |
  a2 |
  r8 f g g |
  d2 |
  r4 g8 a |
  g2 |
  r8 e c a' |
  a2 |
  r4 f8 f |
  bf4 c8 a ~ |
  a f f (g) |
  a2 ~ |
  a4 bf8 bf |
  g4 e8 d ~ |
  d c g'4 ~ |
  g8 a e4 |
  f2 \bar "||" \break
  
  f8 f
  \once \phrasingSlurDashed
  f \(g\) |
  a4. a8 |
  a c d, f |
  g4 e16 ([g]) e (d) |
  c4. c8 |
  f4 e8 (g) |
  
  \pageBreak
  
  \slashedGrace { a16 ( } g2) ~ |
  g4 g8 bf |
  g4. bf8 |
  d4 c8 (bf) |
  c4 r8 a |
  a c f, g16 (f) |
  d4.
  <<
    {
      \voiceOne
      d8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #3
      \tweak font-size #-2
      \parenthesize
      e
    }
  >>
  \oneVoice
  c4 e8 g |
  f2 ~ |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Ai tố con, xin Chúa tố lại.
  Ai đánh con, xin Ngài đánh nó.
  Cầm mộc khiên đứng lên mà trợ giúp,
  Nói với con một lời:
  “Rằng Ta cứu độ con”.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Nguyện bọn tàn _ ác âm mưu tính chuyện hại con
      phải thẹn thùng chạy lui nhục nhã.
      Nguyện ước họ như trấu tung bay,
      Khi thiên sứ Ngài tiễu trừ,
      mong họ không thoát thân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Họ đào hầm _ hố, giăng lên lưới dò hại con,
	    khấn xin Ngài dành cho họ hết,
	    Hầm chúng đào cho chúng sa chân,
	    xin cho chính họ mắc vào
	    \markup { \italic \underline "lưới" }
	    dò họ đã giăng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Được Ngài giải _ thoát
	    con nay hớn hở mừng vui,
	    tiến dâng Ngài lời ca điệu múa,
	    Tự đáy lòng con sẽ tuyên xưng:
	    không ai sánh được như Ngài,
	    muôn đời con kính tin.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Kìa bọn xảo _ trá nêu nhân chứng hạch hỏi con
	    những sự việc mà con chẳng biết.
	    Họ oán thù, con vẫn thi ân,
	    nay mang số phận cô độc,
	    xin Ngài thương cứu con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Họ vừa bị đau yếu, tôi mang áo nhặm vào thân,
	    quyết hãm mình tịnh trai phạt xác,
	    Lòng tôi hằng e ấp câu kinh,
	    lang thang cúi mặt tủi buồn,
	    thương họ như mẫu thân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bọn họ mừng _ rỡ khi tôi mới vừa sẩy chân,
	    kẻ xa lạ hùa theo đập đánh,
	    Họ reo hò, xâu xé khôn ngơi,
	    nhe răng nghiến lợi căm thù,
	    chê cười khiêu khích tôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Phần Ngài, lạy _ Chúa, đang tâm đứng nhìn vậy sao?
	    cứu thân này vượt tay kẻ dữ.
	    Lòng con nguyện vang tiếng tri ân.
	    Nơi công chúng, ngày đô hội,
	    Danh Ngài con tán dương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài đà nhìn _ rõ, sao luôn đứng tận đàng xa?
	    cớ sao đành lặng thinh vậy mãi,
	    Nào thức dậy minh xét cho con.
	    Ôi Thiên Chúa của con này,
	    xin Ngài bênh đỡ con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Nguyện Ngài vùng _ đứng công minh xét xử cho con,
	    Để quân thù đừng lên mặt nữa,
	    Đừng để họ kiêu hãnh cao rao
	    “Ta nay nuốt chửng nó rồi,
	    ôi là vui sướng thay.”
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "10."
      \override Lyrics.LyricText.font-shape = #'italic
	    Còn người nào _ thấy con nay đã được giải oan,
	    hãy vui mừng cùng xương tụng Chúa:
	    “Ngài vĩ đại, ôi Chúa cao quang”.
	    xin ban phúc lộc an bình cho người luôn tín trung.
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
  page-count = 2
}

TongNhip = {
  \key f \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
